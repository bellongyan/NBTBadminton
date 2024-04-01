import preferences from '@ohos.data.preferences';
import Logger from './Logger';

class PreferenceUtil {
  prefMap: Map<string, preferences.Preferences> = new Map()

  async loadPreference(context, name) {
    try { // 加载preferences
      let pref = await preferences.getPreferences(context, name)
      this.prefMap.set(name, pref)
      Logger.debug(`加载Preferences[${name}]成功`)
    } catch (e) {
      Logger.debug(`加载Preferences[${name}]失败`, JSON.stringify(e))
    }
  }

  async putPreferenceValue(name: string, key: string, value: preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      Logger.debug(`Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 写入数据
      await pref.put(key, value)
      // 刷盘
      await pref.flush()
      Logger.debug(`保存Preferences[${name}.${key} = ${value}]成功`)
    } catch (e) {
      Logger.debug(`保存Preferences[${name}.${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType) {
    if (!this.prefMap.has(name)) {
      Logger.debug(`Preferences[${name}]尚未初始化！`)
      return
    }
    try {
      let pref = this.prefMap.get(name)
      // 读数据
      let value = await pref.get(key, defaultValue)
      Logger.debug(`读取Preferences[${name}.${key} = ${value}]成功`)
      return value
    } catch (e) {
      Logger.debug(`读取Preferences[${name}.${key}]失败`, JSON.stringify(e))
    }
  }
}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil